import std.stdio;
import Statistics;
import plt = matplotlibd.pyplot;

void main()
{
	double[] time_series_1;
	double[] time_series_2;

	// Stationary process
	time_series_1 = generate_autoregressive_process(0.0, 0.9, 1.0, 1000);
	time_series_2 = generate_autoregressive_process(0.0, 0.9, 1.0, 1000);
	plt.plot(time_series_1, time_series_2, "r-", ["label": "$rho<1$"]);
	plt.legend();
	plt.savefig("Stationary_Process.png");
	plt.clear();

	// Non-Stationary process
	time_series_1 = generate_autoregressive_process(0.0, 1.0, 1.0, 1000);
	time_series_2 = generate_autoregressive_process(0.0, 1.0, 1.0, 1000);
	plt.plot(time_series_1, time_series_2, "r-", ["label": "$rho=1$"]);
	plt.legend();
	plt.savefig("Non-Stationary_Process.png");
	plt.clear();
}
