function [] = f_make_g(sorting_index, rand_w)

persistent dominant_w
persistent new_generation

if isempty(dominant_w)
    for i=1:25
        dominant_w(i,:) = zeros(1,250);
    end
end


for i=1:25
    dominant_w(i,:) = rand_w(sorting_index(i));
end

for i=26:100
    new_generation(i,:) = 
    