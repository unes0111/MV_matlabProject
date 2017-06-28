
%initials
videosDirectory = '../UCF15/';
outputDirectory = '../Output/';

if exist(outputDirectory, 'dir') == false
	mkdir(outputDirectory);
end

trainTestTables = load(strcat(videosDirectory, 'split.mat'));

categoriesLabels = cell(15, 1);
for i = 1:15
	rowNumber = find([trainTestTables.labtr] == i);
	name = strsplit(trainTestTables.train{rowNumber(1)}, '/');
	categoriesLabels{i} = name{1};
end

clear rowNumber;
clear i;
clear name;

% ExtractFramesOfTrainingVideos(videosDirectory, categoriesLabels, outputDirectory, trainTestTables.train, 1);