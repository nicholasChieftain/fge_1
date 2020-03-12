function [n_gen] = f_make_g(sorting_index, rand_w,sort_ind_x,sort_ind_y)

persistent dominant_w;
persistent idle_of_best_individ;
persistent previous_best;

if isempty(dominant_w)
    n_gen = 0.01*round(100*rand(100, 250));
    for i=1:4
        dominant_w(i,:) = zeros(1,250);
        
    end
    for i=1:3
        idle_of_best_individ(i,:) = zeros(1,250);
    end
    
end

previous_best(1, :) = dominant_w(1, :);


for i=1:4
    dominant_w(i,:) = rand_w(sorting_index(1, i),:);
end

for k=1:3    
    for i=(k+1):4
        for j=1:250
            if dominant_w(k, j) <= dominant_w(i, j)*1.05 && dominant_w(k, j) >= dominant_w(i, j)*0.85
                idle_of_best_individ(k, j) = dominant_w(i, j);
            else 
                if randi([0,1], 1) == 1
                    idle_of_best_individ(k, j) = 0.01*round(100*rand(1));
                else
                    idle_of_best_individ(k, j) = dominant_w(i, j)*0.55;
                end
            end
        end
    end
end

temp_rand = 0.01*round(100*rand(92, 250));

for i=1:250
    temp_rand(1,:) = min(1, max(previous_best(1, i), dominant_w(1, i))*1.2);
    temp_rand(2,:) = max(previous_best(1, i), dominant_w(1, i))*0.6;
    temp_rand(3,:) = min(1, min(previous_best(1, i), dominant_w(1, i))*1.2);
end
    
for j=4:5
    for i=1:125
         temp_rand(j, i) = rand_w(sort_ind_x(1, j-3), i);
         temp_rand(j, i+125) = rand_w(sort_ind_y(1, j-3), i+125);
    end
end


    
for i=6:30
    for j=1:125
        if randi([0,1], 1) == 1
            temp_rand(i, j) = dominant_w(1,j)*0.89;
            temp_rand(i, j+125) = dominant_w(1, j)*0.89;
        else
            temp_rand(i, j) = dominant_w(1, j)*0.35;
            temp_rand(i, j+125) = dominant_w(1, j)*0.35;
        end
    end
end

for i=31:40
    for j=1:250
        if dominant_w(1, j) <= 1.0 && dominant_w(1, j) >= 0.6
            temp_rand(i, j) = min(1, dominant_w(1,j)*1.1);
        else
            temp_rand(i, j) = dominant_w(1, j)*0.7;
        end
    end
end


for i=41:45
    temp_rand(i, :) = rand_w(sorting_index(1, i-40),:);
end

for i=41:45
    for j=1:125
        if temp_rand(i, j) <= 0.1
            temp_rand(i, j) = 0;
        end
    end
end

for i = 46:93
     for j=1:125
        if randi([0,1], 1) == 1
            temp_rand(i, j) = dominant_w(1, j);
            temp_rand(i, j+125) = dominant_w(1,j);
        end
    end
end


n_gen = [dominant_w; idle_of_best_individ; temp_rand];

end
% for i=5:100
%     if dominant_w(
%     new_generation(i,:) = 
    