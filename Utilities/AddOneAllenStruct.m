function structure_3d=AddOneAllenStruct(av_id,av,color_triplet)

if nargin<3
    color_triplet=[0.5 0.5 0.5];
end

%bregma 0
x_bregma=540;
y_bregma=570;
z_bregma=65;

hold on
slice_spacing=10;

if length(av_id)==1
structure_3d = isosurface(permute(av(1:slice_spacing:end,1:slice_spacing:end,1:slice_spacing:end) == av_id,[3,1,2]),0);
else
structure_3d = isosurface(permute(av(1:slice_spacing:end,1:slice_spacing:end,1:slice_spacing:end) >= av_id(1) &...
    av(1:slice_spacing:end,1:slice_spacing:end,1:slice_spacing:end) <= av_id(end),[3,1,2]),0);
end

close();


end