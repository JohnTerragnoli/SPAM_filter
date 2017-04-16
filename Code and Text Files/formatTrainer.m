%% load the data
importAllData
%% format train subjects

% sort by file name
sorted = sortrows(subjectstrain);
sorted(:,1)=[];

% compare words
words = zeros(size(sorted));
for n=1:size(sorted,1) % every email
    for k=1:size(keywords,1) % every keyword
        for w = 1:size(sorted, 2) % every word in the subject
            if strcmp(sorted{n,w}, keywords{k})
                words(n,w) = 1;
                break
            end
        end
    end
end
