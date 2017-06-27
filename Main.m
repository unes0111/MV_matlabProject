


videosDirectory = 'F:\Dars\Term8\MV\Project\UCF15\';

load(strcat(videosDirectory, 'split.mat'));

labelNames = cell(15, 1);
for i = 1:15
	[r, c] = find([labtr] == i);
	str = train{r(1)};
	name = strsplit(str, '/');
	labelNames{i} = name{1};
end

clear r;
clear c;
clear str;
clear i;
clear name;
