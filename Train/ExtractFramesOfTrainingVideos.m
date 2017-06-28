function ExtractFramesOfTrainingVideos(trainingVideosDirectory, categoriesLabels, outputDirectory, train, framesCount)
% frame haye video ha ra joda mikonad va bar asase daste bandi dar poshe
% moshkhas shode gharar midahad

directoryName = 'Frames';

directory = strcat(outputDirectory, '/', directoryName);
if exist(directory, 'dir')
	rmdir(directory, 's')
end

mkdir(directory);
for i = 1:size(categoriesLabels)
	mkdir(directory, categoriesLabels{i});
end

fprintf('Extracting frames of training videos   0%%\n');
trainSize = size(train);
for i = 1:trainSize(1)
	
	fprintf('%c%c%c%c%c%3d%%\n', 8, 8, 8, 8, 8, int16(i * 100 / trainSize(1)));
	
	video = VideoReader(strcat(trainingVideosDirectory, char(train(i, 1))));
	
	% distance between indexes of tow sequential frames
	framesDistance = floor(video.Duration * video.FrameRate / framesCount);
	
	% duration of a frame in second
	frameDuration = floor(1 / video.FrameRate);
	
	for j = 0:framesCount -1
		video.CurrentTime = framesDistance * frameDuration * j;
		frame = readFrame(video);
		name = strsplit(train{i, 1}, '.');
		imwrite(frame, strcat(outputDirectory, '/', directoryName, '/', name{1}, '_', num2str(j + 1, '%03d'), '.jpg'));
	end
end

fprintf('Extraction finished. %d frames extracted from %d viedos in %d categories.\n', (i * framesCount), i, size(categoriesLabels, 1));

end