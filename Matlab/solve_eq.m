% Define symbolic variables
syms M m theta l F vtheta atheta a g

% Define the system of equations
eq1 = (M+m)*a + M*l*cos(theta)*atheta == F + M*l*vtheta^2*sin(theta);
eq2 = cos(theta)*a + l*atheta == -g*sin(theta);

% Solve the equations
solution = solve([eq1, eq2], [a, F]);

% Extract the solutions
a_solution = simplify(solution.a)
F_solution = simplify(solution.F)

