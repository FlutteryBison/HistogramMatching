function [matched_mappings] = histogram_match_mappings(input_eq_mappings,target_eq_mappings)
%HISTOGRAM_MATCH Summary of this function goes here
%   Detailed explanation goes here

matched_mappings = zeros(size(input_eq_mappings,1),1);

for i = 1:size(input_eq_mappings,1)
    % Value intensity is mapped to at the input
    eq_map = input_eq_mappings(i,1);

    % Temporary "distances" array.
    temp = abs(eq_map - target_eq_mappings);

    matched_mappings(i,1) = find(temp == min(temp),1)-1;


end

