% 此函数用于将矩阵A的元素全部打乱顺序，随机排列
function y = RandomPermutation(A)

[r, c] = size(A);
b = reshape(A, r * c, 1);       % convert to column vector
x = randperm(r * c);            % make integer permutation of similar array as key
w = [b, x'];                    % combine matrix and key
d = sortrows(w, 2);             % sort according to key
y = reshape(d(:, 1), r, c);     % return back the matrix
