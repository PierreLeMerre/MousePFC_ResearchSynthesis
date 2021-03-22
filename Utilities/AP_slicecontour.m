function contourHands = AP_slicecontour(volData, contourHeight, slice, origin)

hold on;

% contours of a coronal slice, i.e. at one AP (x) location, 1um space
xSlices = origin(1)+(-1000:1000)*1;
xSlices = xSlices(xSlices>slice & xSlices<=slice+1);
contourHands{1} = {};
 %x = origin(1)+slicelocation;
 
 for x = xSlices
     thisSlice = squeeze(volData(x,:,:));
 
    
    % compute the contours
    c = contourc(thisSlice, contourHeight*[1 1]);
    cP = parseContours(c);
    
    % plot the contours

    contourHands{1}{end+1} = cellfun(@(yz)plot(yz(1,:), -yz(2,:), 'Color', [0 0 0 0.3]), cP, 'uni', false);  
   
end



