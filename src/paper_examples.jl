include("Convex.jl")
using Convex
using ECOS, SCS

# Summation.
println("Summation example")
x = Variable();
e = 0;
@time begin
  for i = 1:1000
    e += x;
  end
  p = minimize(e, x>=1);
end
@time solve!(p, ECOS.ECOSMathProgModel())

# Indexing.
println("Indexing example")
x = Variable(1000, 1);
e = 0;
@time begin
  for i = 1:1000
    e += x[i];
  end
  p = minimize(e, x >= ones(1000, 1));
end
@time solve!(p, ECOS.ECOSMathProgModel())

# Matrix constraints.
println("Matrix constraint example")
n, m, p = 100, 100, 100
X = Variable(m, n);
A = randn(p, m);
b = randn(p, n);
@time begin
  p = minimize(vecnorm(X), A * X == b);
end
@time solve!(p, ECOS.ECOSMathProgModel())

# Transpose.
println("Transpose example")
X = Variable(5, 5);
A = randn(5, 5);
@time begin
  p = minimize(norm2(X - A), X' == X);
end
@time solve!(p, ECOS.ECOSMathProgModel())

n = 3
A = randn(n, n);
#@time begin
  X = Variable(n, n);
  p = minimize(vecnorm(X' - A), X[1,1] == 1);
  solve!(p, ECOS.ECOSMathProgModel())
#end
