function f_write_log(Data)
persistent FID
% Open the file
if strcmp(Data, 'open')
  FID = fopen(fullfile('/Users/nicholas_chieftain/Учеба/fge_1/log', 'LogFile.txt'), 'w');
  if FID < 0
     error('Cannot open file');
  end
  return;
elseif strcmp(Data, 'close')
  fprintf(FID, '%s\n', Data);
  fclose(FID);
  FID = -1;
end

end
% Write to the screen at the same time:
% fprintf('%s\n', Data);