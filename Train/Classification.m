function [trainingImgageSets, bagOfFeature, categoryClassifier] = Classification(trainingImagesDirectory, categoriesLabels, outputDirectory)
% baraye ejade pakate kalamat va date bandi

variablesDirectory = strcat(outputDirectory, 'Variables/');

if exist(variablesDirectory, 'dir') && exist(strcat(variablesDirectory, 'classification.mat'), 'file')
	disp('Loading stored classification variables...');
	load(strcat(variablesDirectory, 'classification.mat'));
else
	format shortg;
	startTime = clock();
	
	if exist(variablesDirectory, 'dir')
		rmdir(variablesDirectory, 's')
	end
	mkdir(variablesDirectory);
	
	for i = 1:size(categoriesLabels, 1)
		trainingImgageSets(i) = imageSet(fullfile(trainingImagesDirectory, categoriesLabels{i, 1}));
	end
	
	{trainingImgageSets.Description}
	[trainingImgageSets.Count]
	
	% min tedad frame ha dar daste ha
	minSetCount = min([trainingImgageSets.Count]);
	
	%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	% yeksan kardane size daste ha
	trainingImgageSets = partition(trainingImgageSets, minSetCount, 'randomize');
	[trainingImgageSets.Count]
	
	% ------------------!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
	trainingImgageSets = partition(trainingImgageSets, 0.01, 'randomize');
	
	% bag of features (SURF, k_Means with k = 500, turn on log)
	bagOfFeature = bagOfFeatures(trainingImgageSets, 'Verbose', true);
	
	% SVM
	categoryClassifier = trainImageCategoryClassifier(trainingImgageSets, bagOfFeature);
	
	save(strcat(variablesDirectory, 'classification.mat'), 'trainingImgageSets', 'bagOfFeature', 'categoryClassifier');
	
	format shortg;
	endTime = clock();
	
	duration = endTime - startTime;
	seconds = duration(4) * 3600 + duration(5) * 60 + duration(6);
	hour = fix(seconds / 3600);
	minute = fix((seconds - hour*3600) / 60);
	sec = seconds - hour * 3600 - minute * 60;
	%ms = (seconds - hour*3600 - min*60 - seconds) * 1000;
	fprintf('Execute time : %d : %d : %d\n', hour, minute, sec);
end

end

