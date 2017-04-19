%% format labels into confusion matrix
function [ truth, predicted ]= labelsConfusion( true_labels, p_labels, title, axis )

% check optional input argument
switch nargin
    case 1
        error('Too few input arguments');
    case 2
        title = '';
        axis = unique(true_labels);
    case 3
        axis = unique(true_labels);        
end

% get sizes
nClass = numel(unique(true_labels));
nSamp = size(true_labels, 1);
% init arrays
truth = zeros(nClass, nSamp);
predicted = zeros(nClass, nSamp); 

% format truth
for i = 1:nSamp
    index = int32(true_labels(i)) + 1;
    truth(index, i) = 1;
end
% format predictions
for i = 1:size(p_labels,1)
    index = int32(p_labels(i)) + 1;
    predicted(index, i) = 1;
end

figure
plotconfusion(truth, predicted, title);
set(gca,'yticklabel', axis)
set(gca,'xticklabel', axis)

end

