import std.stdio;
import std.range;
import Statistics;
import plt = matplotlibd.pyplot;

void main()
{
	double[] time_series;

	int n = 1000;
	double[] t;
	for (int i = 0; i<n; i++) {t ~= i;}

	time_series = generate_autoregressive_process(0.1, 1.0, 1.0, n);
	plt.plot(t, time_series, "o", ["markersize": 0.5]);
	plt.legend();
	plt.grid();
	plt.savefig("Random Process.png");
	plt.clear();
}
