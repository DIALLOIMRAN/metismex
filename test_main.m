function test_main
A = spaugment(ones(5)); A(1,10) = 1; A(10,1) = 1; A(5,6) = 1; A(6,5) = 1;
map = metismex('PartGraphRecursive',sparse(A),2);
diff = 0;
for i=1:20
    map2 = metismex('PartGraphRecursive',sparse(A),2,struct('seed',i));
    diff = any(map ~= map2);
    if diff, break; end
end
assert(diff)

for i=2:5
    map = metismex('PartGraphKway',sparse(A),i);
    assert(max(map) == i-1);
end

A = blkdiag(ones(5),ones(5)); A(1,10) = 1; A(10,1) = 1; A(5,6) = 1; A(6,5) = 1;
[p1,p2] = metispart(sparse(A));
assert(all(p1-[1,2,3,4,5] == 0))