% Define the filename
filename = 'crane_poly_abrupt_060_075.csv';

% Read the CSV file
data = readtable(filename);

% Determine the number of rows in the data
numRows = size(data, 1);

% Remove the last 38000 rows
data = data(1:(numRows - 38000), :);

% Save the modified data back to the same file
writetable(data, filename);