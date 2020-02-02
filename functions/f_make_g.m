function [n_gen] = f_make_g(sorting_index, rand_w)

persistent dominant_w
persistent idle_of_best_individ

if isempty(dominant_w)
    n_gen = 0.01*round(100*rand(100, 250));
    for i=1:4
        dominant_w(i,:) = zeros(1,250);
        idle_of_best_individ(i,:) = zeros(1,250);
    end
end


for i=1:4
    dominant_w(i,:) = rand_w(sorting_index(1, i),:);
end

for k=1:3    
    for i=(k+1):4
        for j=1:250
            if dominant_w(k, j) <= dominant_w(i, j)*1.05 && dominant_w(k, j) >= dominant_w(i, j)*0.85
                idle_of_best_individ(k, j) = dominant_w(i, j);
            else 
                idle_of_best_individ(k, j) = 0.01*round(100*rand(1));
            end
        end
    end
end

temp_rand = 0.01*round(100*rand(92, 250));

for i=1:92
    for j=1:125
        if randi([0,1], 1) == 1
            temp_rand(i, j) = dominant_w(1,randi([1,125],1));
            temp_rand(i, j+125) = dominant_w(1,randi([126,250],1));
        end
    end
end


n_gen = [dominant_w; idle_of_best_individ; temp_rand]

end
% for i=5:100
%     if dominant_w(
%     new_generation(i,:) = 
    