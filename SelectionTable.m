function [data] = SelectionTable()

global n
f = figure('Name', 'Input Data');
t = uitable(f,'Position', [10 10 530 221]);
x = zeros(n,5);
x(:,1) = 3;
x(:,2) = 3;
x(:,3) = .25;
x(:,4) = 90;
x(:,5) = .64;
x(2,4) = 0;
x(5,4) = 0;

%Create Fiber Selection Options on Table
fiberlist = {'FIBER MATERIALS', ' 1) Boron', ' 2) HMS  ', '3) AS4  ', '4) Approximate I-Beam Web ', '5) TS 3000', '6) KEV  ', '7) S-G  ','8) E-G  '};
flegend = uicontrol('Style','Text');
set(flegend, 'string', fiberlist, 'Position', [60 275 150 145])

%Create Matrix Selection Options on Table
matrixlist = {'MATRIX MATERIALS', '1) LM       ', ' 2) IMLS     ', '  3) IMHS      ', '4) HM       ', '   5) Polyimide', ' 6) PMR      '};
mlegend = uicontrol('Style', 'Text');
set(mlegend, 'string',matrixlist, 'Position', [350 300 100 100])

%Create Data table for the user to put in information
cnames = {'Fiber Material', 'Matrix Material', 'Ply Thickness (mm)', 'Angle (degrees)', 'Volume Fraction of Fibers'};
set (t, 'Data',x,  'ColumnEditable', true(1,5), 'ColumnName', cnames);

%Allow the user to select to save the changes or not (stores table into
%data)
result = menu('Save Changes?', 'OK');
if (result == 1) 
data = get(t, 'Data'); %Matrix of selected values
close(f)
end


end
