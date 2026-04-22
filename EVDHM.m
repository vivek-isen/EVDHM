function comps = EVDHM(signal,Ns,flag)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input parameters
% signal   :   Input signal
% Ns       :   Number of significant eigenvalue pairs to be considered
% flag     :   Flag for printing significant eigenvalue pairs
%-------------------------------------------------------------------------
% Output parameters
% comps   :   Decomposed signal components
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author   :   Vivek Kumar Singh, PhD
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = length(signal);
if rem(N,2) == 0
    error("Signal must have odd number of samples!")
end
K = (N+1)/2;
X = hankel(signal(1:K),signal(K:end));
[U,L] = eig(X);
L = diag(L);
comps = zeros(N,Ns);
for i = 1:Ns
    X1 = U(:,i)*L(i)*U(:,i)' + U(:,end-i+1)*L(end-i+1)*U(:,end-i+1)';
    comps(:,i) = DiagonalAveraging(X1);
    if flag == 1
        fprintf('Eigenvalue pair %d: {%f, %f}\n', i, L(i), L(end-i+1));
    end
end
end