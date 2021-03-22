function DEPTH = get_APSlice_surfacedepth(volData, AP, ML, origin)

contourHands = AP_slicecontour(volData, 0.5, AP, origin);
lines=contourHands{1, 1}{1, 1};

IDX=[];
 depth=nan(1,numel(lines));
for i=1:numel(lines)
    h=lines{i};
    x=h.XData;
    y=h.YData;
    idx=find(x==(ML+origin(2)));   
    if isempty(idx)
        %disp('Point is out of the section limits')
        depth(i) = NaN;
    else
        depth(i) = unique(max(y(idx)));        
    end
end
DEPTH=max(depth);
plot(origin(2)+ML,depth,'ko','MarkerSize',10,'MarkerFaceColor',[0 0 1])

end