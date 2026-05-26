% 模拟退火 (SA) 模板
% 适用：组合优化/单目标优化
% 适配点：
%   1. 修改 obj_func() —— 定义目标函数
%   2. 修改 init_solution() —— 定义初始解的生成方式
%   3. 修改 neighbor() —— 定义邻域生成策略
%   4. 调整参数 T0/alpha/L/max_iter 适配具体问题

function [best_sol, best_fit, history] = sa_template(obj_func, n_var, bounds, T0, alpha, L, max_iter)
    % Parameters:
    %   obj_func  - function handle, 计算目标值, 越小越好
    %   n_var     - 变量个数
    %   bounds    - n_var x 2 矩阵, 每行 [low, high]
    %   T0        - 初始温度 (默认 1000)
    %   alpha     - 降温系数 (默认 0.95)
    %   L         - 每个温度下的迭代链长 (默认 100)
    %   max_iter  - 最大外层迭代 (默认 5000)

    if nargin < 4, T0 = 1000; end
    if nargin < 5, alpha = 0.95; end
    if nargin < 6, L = 100; end
    if nargin < 7, max_iter = 5000; end

    T_min = 0.01;  % 最低温度
    history.best_fitness = zeros(max_iter, 1);
    history.temperature = zeros(max_iter, 1);

    % 初始化
    current = init_solution(bounds, n_var);
    current_fit = obj_func(current);
    best_sol = current;
    best_fit = current_fit;
    T = T0;

    for it = 1:max_iter
        for k = 1:L
            % 生成邻域解
            neighbor = generate_neighbor(current, bounds, T, T0);
            neighbor_fit = obj_func(neighbor);

            delta = neighbor_fit - current_fit;  % 正=neighbor更差(最小化视角)

            if delta < 0  % neighbor 更好，接受
                current = neighbor;
                current_fit = neighbor_fit;
            else
                p = exp(-delta / T);
                if rand() < p  % 以概率接受更差解
                    current = neighbor;
                    current_fit = neighbor_fit;
                end
            end

            if current_fit < best_fit  % 更新最优解
                best_sol = current;
                best_fit = current_fit;
            end
        end

        T = T * alpha;
        history.best_fitness(it) = best_fit;
        history.temperature(it) = T;

        if mod(it, 50) == 0
            fprintf('Iter %5d | T: %.3f | Best: %.6f\n', it, T, best_fit);
        end

        if T < T_min
            break;
        end
    end

    % 截断未填满的历史记录
    history.best_fitness = history.best_fitness(1:it);
    history.temperature = history.temperature(1:it);

    fprintf('\n=== SA 求解完成 ===\n');
    fprintf('最优适应度: %.6f\n', best_fit);
end

function x = init_solution(bounds, n_var)
    % TODO: 替换为符合问题约束的初始化方式
    x = zeros(1, n_var);
    for i = 1:n_var
        x(i) = bounds(i,1) + rand() * (bounds(i,2) - bounds(i,1));
    end
end

function neighbor = generate_neighbor(x, bounds, T, T0)
    % TODO: 替换为符合问题结构的邻域生成策略
    % 当前为连续变量的高斯扰动（幅度随温度减小）
    n_var = length(x);
    neighbor = x;
    for i = 1:n_var
        scale = (bounds(i,2) - bounds(i,1)) * 0.1 * (T / T0 + 0.01);
        neighbor(i) = x(i) + randn() * scale;
        % 边界约束
        neighbor(i) = max(bounds(i,1), min(bounds(i,2), neighbor(i)));
    end
end


% ===== 使用示例 (取消注释运行) =====
%{
function f = example_obj(x)
    % 示例目标函数：Rastrigin 函数 (最小化为0，在 x=0 处)
    f = sum(x.^2 - 10*cos(2*pi*x) + 10);
end

bounds = [-5.12, 5.12; -5.12, 5.12];  % 2维变量
[best_sol, best_fit, history] = sa_template(@example_obj, 2, bounds, 1000, 0.95, 100, 2000);

figure;
subplot(2,1,1); plot(history.best_fitness); xlabel('Iter'); ylabel('Best Fitness'); title('收敛曲线');
subplot(2,1,2); plot(history.temperature); xlabel('Iter'); ylabel('Temperature'); title('温度下降');
%}
