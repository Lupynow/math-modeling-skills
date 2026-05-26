% 蒙特卡洛模拟 (Monte Carlo Simulation) 模板
% 适用：不确定性分析、风险量化、随机系统模拟
% 适配点：
%   1. 修改 sample_inputs() —— 定义输入参数的概率分布
%   2. 修改 run_single_trial() —— 定义单次试验的输入-输出逻辑
%   3. 调整 n_trials（试验次数）和置信水平 alpha

function [results, summary] = monte_carlo_template(n_trials, alpha, use_lhs)
    % Parameters:
    %   n_trials - 模拟次数 (默认 10000)
    %   alpha    - 显著性水平, 置信区间为 (1-alpha)*100% (默认 0.05)
    %   use_lhs  - 是否使用拉丁超立方采样 (默认 false, 需要 Statistics Toolbox)

    if nargin < 1, n_trials = 10000; end
    if nargin < 2, alpha = 0.05; end
    if nargin < 3, use_lhs = false; end

    rng(42);  % 固定随机种子，保证可复现

    % Step 1: 生成输入样本
    fprintf('生成 %d 组输入参数样本...\n', n_trials);
    inputs = sample_inputs(n_trials, use_lhs);

    % Step 2: 运行模拟
    fprintf('运行模拟...\n');
    results = zeros(n_trials, 1);
    report_interval = max(1, floor(n_trials / 20));  % 每 5% 汇报一次

    for i = 1:n_trials
        params = struct();
        fns = fieldnames(inputs);
        for j = 1:length(fns)
            params.(fns{j}) = inputs.(fns{j})(i);
        end
        results(i) = run_single_trial(params);

        if mod(i, report_interval) == 0
            fprintf('  进度: %d / %d (%.0f%%)\n', i, n_trials, 100*i/n_trials);
        end
    end

    % Step 3: 统计汇总
    summary = compute_summary(results, alpha);

    % Step 4: 输出结果
    fprintf('\n=== 蒙特卡洛模拟结果汇总 ===\n');
    fprintf('样本量: %d\n', n_trials);
    fprintf('均值: %.4f\n', summary.mean);
    fprintf('标准差: %.4f\n', summary.std);
    fprintf('中位数: %.4f\n', summary.median);
    fprintf('95%% 置信区间: [%.4f, %.4f]\n', summary.ci95(1), summary.ci95(2));
    fprintf('P5: %.4f  |  P95: %.4f\n', summary.p5, summary.p95);
    fprintf('偏度: %.4f\n', summary.skewness);

    % Step 5: 可视化
    plot_results(results, summary);
end

function inputs = sample_inputs(n, use_lhs)
    % TODO: 替换为实际问题的输入参数分布
    % 支持的分布：
    %   randn(n,1) * sigma + mu       — 正态分布 N(mu, sigma^2)
    %   rand(n,1) * (high-low) + low  — 均匀分布 U(low, high)
    %   triangular_dist(n, low, mode, high) — 三角分布 (自定义函数)
    %   常数 — ones(n,1) * value

    if use_lhs
        % 拉丁超立方采样 (需要 Statistics and Machine Learning Toolbox)
        % 生成 [0,1] 区间均匀分布，再通过逆变换映射到目标分布
        lhs_samples = lhsdesign(n, 3);  % 3 个参数

        % 映射到目标分布
        inputs.demand = norminv(lhs_samples(:,1), 100, 15);     % 正态分布
        inputs.unit_cost = lhs_samples(:,2) * 4 + 8;            % 均匀分布 U(8, 12)
        inputs.lead_time = round(lhs_samples(:,3) * 8 + 2);     % 均匀离散 U(2, 10)
    else
        % 简单随机采样
        inputs.demand = randn(n, 1) * 15 + 100;                 % 正态分布 N(100, 15)
        inputs.unit_cost = rand(n, 1) * 4 + 8;                 % 均匀分布 U(8, 12)
        inputs.lead_time = randi([2, 10], n, 1);               % 均匀离散 U(2, 10)
    end
end

function output = run_single_trial(params)
    % TODO: 替换为实际问题的单次模拟逻辑
    % params 是包含所有输入参数的结构体

    % 示例：简单利润模型
    order_qty = 120;
    revenue = 50 * min(params.demand, order_qty);
    cost = params.unit_cost * order_qty;
    shortage_cost = 20 * max(params.demand - order_qty, 0);
    output = revenue - cost - shortage_cost;
end

function s = compute_summary(results, alpha)
    n = length(results);
    s.mean = mean(results);
    s.std = std(results);
    s.median = median(results);
    s.p5 = prctile(results, 5);
    s.p95 = prctile(results, 95);
    s.min_val = min(results);
    s.max_val = max(results);
    s.skewness = skewness(results);

    % 置信区间 (基于正态假设)
    se = s.std / sqrt(n);
    z = norminv(1 - alpha / 2);
    s.ci95 = [s.mean - z * se, s.mean + z * se];
    s.ci_width = s.ci95(2) - s.ci95(1);

    % 收敛检查 (CI 宽度随样本量的变化)
    check_points = 20;
    sizes = round(linspace(100, n, check_points));
    s.convergence = zeros(check_points, 2);
    for i = 1:check_points
        sample = results(1:sizes(i));
        se_i = std(sample) / sqrt(sizes(i));
        s.convergence(i,:) = [sizes(i), 2 * z * se_i];
    end
end

function plot_results(results, summary)
    % 直方图 + 收敛曲线
    figure('Position', [100, 100, 1200, 450]);

    subplot(1,2,1);
    histogram(results, 50, 'Normalization', 'pdf', 'FaceColor', [0.27, 0.51, 0.71], ...
        'EdgeColor', 'white', 'FaceAlpha', 0.7);
    hold on;
    % KDE (使用 ksdensity)
    [kde_x, kde_y] = ksdensity(results);
    plot(kde_x, kde_y, 'r-', 'LineWidth', 2);
    xline(summary.mean, 'r--', 'LineWidth', 1.5);
    xline(summary.ci95(1), 'Color', [0.85, 0.33, 0.1], 'LineStyle', '--', 'LineWidth', 1);
    xline(summary.ci95(2), 'Color', [0.85, 0.33, 0.1], 'LineStyle', '--', 'LineWidth', 1);
    xlabel('Output'); ylabel('Density'); title('Output Distribution');
    legend({'Histogram', 'KDE', 'Mean', '95% CI'}, 'Location', 'best');
    hold off;

    subplot(1,2,2);
    plot(summary.convergence(:,1), summary.convergence(:,2), 'b-o', ...
        'MarkerSize', 3, 'LineWidth', 1.5);
    xlabel('Sample Size'); ylabel('CI Width');
    title('Convergence Check');
    grid on;

    sgtitle('Monte Carlo Simulation Results');
end

function x = triangular_dist(n, low, mode, high)
    % 三角分布采样 (逆变换法)
    F_mode = (mode - low) / (high - low);
    u = rand(n, 1);
    x = zeros(n, 1);
    mask = u < F_mode;
    x(mask) = low + sqrt(u(mask) * (high - low) * (mode - low));
    x(~mask) = high - sqrt((1 - u(~mask)) * (high - low) * (high - mode));
end


% ===== 使用示例 (取消注释运行) =====
%{
[results, summary] = monte_carlo_template(5000, 0.05, false);
%}
