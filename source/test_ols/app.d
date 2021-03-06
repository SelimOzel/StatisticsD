import std.stdio;
import std.range;
import Statistics;
import plt = matplotlibd.pyplot;

void main()
{
	double[] time_series;
	double[] time_series_estimated;
	double[2] ols;

	int n = 1000;
	double[] t;
	for (int i = 0; i<n; i++) {t ~= i;}

	time_series = generate_autoregressive_process(0.1, 1.0, 1.0, n);
	ols = compute_ordinary_least_squares(t, time_series);
	for (int i = 0; i<n; i++) {time_series_estimated ~= ols[0] + ols[1]*i;}

	plt.plot(t, time_series, "o", ["markersize": 0.5]);
	plt.plot(t, time_series_estimated, "r-");
	plt.legend();
	plt.grid();
	plt.savefig("Random Process.png");
	plt.clear();
}
