import std.stdio;
import std.range;
import Statistics;
import plt = matplotlibd.pyplot;

void main()
{
	double[] time_series_1;
	double[] time_series_2;

	int n = 1000;
	double[] t;
	for (int i = 0; i<n; i++) {t ~= i;}

	// Stationary process
	time_series_1 = generate_autoregressive_process(1.0, 0.95, 1.0, n);
	time_series_2 = generate_autoregressive_process(1.0, 0.95, 1.0, n);
	writeln(compute_mean(time_series_1));
	writeln(compute_std(time_series_1));
	writeln(compute_correlation(time_series_1, time_series_2));
	writeln();
	plt.plot(t, time_series_1, "r-", ["label": "$rho<1$"]);
	plt.plot(time_series_2, "b-", ["label": "$rho<1$"]);
	plt.legend();
	plt.savefig("Stationary_Process.png");
	plt.clear();

	// Non-Stationary process
	time_series_1 = generate_autoregressive_process(0.0, 1.0, 1.0, n);
	time_series_2 = generate_autoregressive_process(0.0, 1.0, 1.0, n);
	writeln(compute_mean(time_series_1));
	writeln(compute_std(time_series_1));
	writeln(compute_correlation(time_series_1, time_series_2));
	writeln(compute_ordinary_least_squares(time_series_1, time_series_2));
	writeln();
	plt.plot(time_series_1, "r-", ["label": "$rho=1$"]);
	plt.plot(time_series_2, "b-", ["label": "$rho=1$"]);
	plt.legend();
	plt.savefig("Non-Stationary_Process.png");
	plt.clear();
}
