import std.math: sqrt, pow;
import std.exception: enforce;
import std.random: dice;

/* 
	Mean value of a time series
*/ 
double compute_mean(double[] array_IN) pure {
	double sum = 0;
	int n = array_IN.length;
	for(int i = 0; i<n; i++) { sum += array_IN[i]; }
	return sum/n;
}

/*
	Standard deviation of a time series
*/
double compute_std(double[] array_IN) pure {
	double sum = 0;
	int n = array_IN.length;
	for(int i = 0; i<n; i++) { sum += pow((array_IN[i]-compute_mean(array_IN)),2); }
	return sum/n;	
}

/* 
	Correlation between two time series.
*/ 
double compute_correlation(double[] array_x_IN, double[] array_y_IN) pure {
	enforce(array_x_IN.length == array_y_IN.length, "compute_correlation: not same length"); 
	int n = array_x_IN.length;
	double x_mean = compute_mean(array_x_IN);
	double y_mean = compute_mean(array_y_IN);
	double numerator = 0.0;
	double denominator = 0.0;
	for (int i = 0; i<n; i++) {
		numerator += (array_x_IN[i]-x_mean)*(array_y_IN[i]-y_mean);
		denominator += sqrt(pow(array_x_IN[i]-x_mean, 2)*pow(array_y_IN[i]-y_mean, 2));
	}
	return numerator/denominator;
}

/* 
	y_t = alpha + rho*x_t + e_t
	Computes rho_est and alpha_est based on n observations given time series x_t and y_t where e_t is random noise
*/ 
double[2] compute_ordinary_least_squares(double[] array_x_IN, double[] array_y_IN) pure {
	enforce(array_x_IN.length == array_y_IN.length, "compute_ordinary_least_squares: not same length"); 
	int n = array_x_IN.length;
	double rho_est = 0.0;
	double alpha_est = 0.0;
	double sum_xi_times_yi = 0.0;
	double sum_xi = 0.0;
	double sum_yi = 0.0;
	double sum_xi_sqrd = 0.0;
	double[] error_term;
	for (int i = 0; i<n; i++) {
		sum_xi_times_yi += array_x_IN[i]*array_y_IN[i];
		sum_xi += array_x_IN[i];
		sum_yi += array_y_IN[i];
		sum_xi_sqrd += pow(array_x_IN[i],2);
	}
	rho_est = ( sum_xi_times_yi - 1/n*sum_xi*sum_yi ) / ( sum_xi_sqrd - 1/n*pow(sum_xi,2) );
	for (int i = 0; i<n; i++) {
		error_term ~= array_y_IN[i]-rho_est*array_x_IN[i];
	}
	alpha_est = compute_mean(error_term);
	return [rho_est, alpha_est];
}

/*
	y_t = alpha + rho*x_t + e_t
	Generate data points from an autoregressive process as a double vector
*/
double[] generate_autoregressive_process(double alpha, double rho, double e_t, int n) {
    double y = 0;
    double[] time_series;
    for (int i = 0; i<n; i++) {
        if (dice(0.5, 0.5) == 1) y = alpha + rho*y + e_t;
        else y = alpha + rho*y - e_t;
        time_series ~= y;   	
    }
    return time_series;
}