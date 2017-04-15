%% Import the Correct Labels and Names
filename = 'SPAMTrain.txt';
delimiter = ' ';
formatSpec = '%f%q%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
SPAMTrain = table(dataArray{1:end-1}, 'VariableNames', {'VarName1','TRAIN_00000eml'});
labels = table2array(SPAMTrain(:,1));
names = table2array(SPAMTrain(:,2));
clearvars filename delimiter formatSpec fileID dataArray ans SPAMTrain;




%% Import Subject Lines from Training Data
%Each email is represented by a row, each word of that subject goes in a
%specific column.   
filename = 'subjects_train.txt';
delimiter = ' ';
formatSpec = '%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
subjectstrain = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;


%% Import Subject Lines from Testing Data
%Each email is represented by a row, each word of that subject goes in a
%specific column.   
filename = 'subjects.txt';
delimiter = ' ';
formatSpec = '%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%q%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'EmptyValue' ,NaN, 'ReturnOnError', false);
fclose(fileID);
subjects = [dataArray{1:end-1}];
clearvars filename delimiter formatSpec fileID dataArray ans;


%% Import Keywords
%Each email is represented by a row, each word of that subject goes in a
%specific column. 
filename = 'keywords.txt';
delimiter = '';
formatSpec = '%s%[^\n\r]';
fileID = fopen(filename,'r');
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);
fclose(fileID);
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));
rawNumericColumns = {};
rawCellColumns = raw(:, 1);
keywords = rawCellColumns(:, 1);
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawNumericColumns rawCellColumns;