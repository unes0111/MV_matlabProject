function ExtractFramesOfTrainingVideos(trainingVideosDirectory, labelNames, outputDirectory, train, framesCount)
% frame haye video ha ra joda mikonad va bar asase daste bandi dar poshe
% moshkhas shode gharar midahad

directory = strcat(outputDirectory, '/Frames');
mkdir(directory);
for i = 1:size(labelNames)
	mkdir(directory, labelNames{i});
end



for i = 1:trainSize
	video = VideoReader(strcat(trainingVideosDirectory, char(train(i, 1))));
	
	% distance between indexes of tow sequential frames
	framesDistance = floor(video.Duration * video.FrameRate / framesCount);
	
	% duration of a frame in second
	frameDuration = floor(1 / video.FrameRate);
	
	
	for j = 0:framesCount -1
		video.CurrentTime = framesDistance * frameDuration * j;
		frame = readFrame(video);
		name = strsplit(train{i, 1}, '.');
		imwrite(frame, strcat('Frames/', name{1}, '--', int2str(j + 1), '.jpg'));
	end
end

end