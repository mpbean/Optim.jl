function f(x)
  (309.0 - 5.0 * x[1])^2 + (17.0 - x[2])^2
end
function g(x)
  [-10.0 * (309.0 - 5.0 * x[1]), -2.0 * (17.0 - x[2])]
end

initial_x = [10.0, 10.0]
m = 10

store_trace, show_trace = false, false
results = Optim.l_bfgs(f, g, initial_x, m, 10e-8, 1_000,
	                   store_trace, show_trace)
@assert length(results.trace.states) == 0
@assert results.converged
@assert norm(results.minimum - [309.0 / 5.0, 17.0]) < 0.01

results = Optim.l_bfgs(f, g, initial_x)
@assert length(results.trace.states) == 0
@assert results.converged
@assert norm(results.minimum - [309.0 / 5.0, 17.0]) < 0.01

store_trace, show_trace = true, false
results = Optim.l_bfgs(f, g, initial_x, m, 10e-8, 1_000,
	                   store_trace, show_trace)
@assert length(results.trace.states) > 0
@assert results.converged
@assert norm(results.minimum - [309.0 / 5.0, 17.0]) < 0.01
