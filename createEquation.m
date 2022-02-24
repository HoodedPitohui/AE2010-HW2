function [eq] = createEquation(givenArray)
    syms T;
    eq = givenArray(1) + givenArray(2) * T + givenArray(3) * T^2 + ...
    givenArray(4) * T^3 + givenArray(5) * T^4;
end