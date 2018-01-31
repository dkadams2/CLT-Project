function [NM] = askforces()
%Opens a dialog box and asks the user to input the stresses on the
%composite. Creates the stress matrix.
prompt = {'Nx','Ny','Nxy','Mx','My','Mxy'};
dlg_title = 'Forces Applied on Composite' ;
   num_lines = 1;
   def = {'.423','0','0','0','0','0'};
   answer = inputdlg(prompt,dlg_title,num_lines,def);
   y = answer;
   Nx = str2num(y{1});  
   Ny = str2num(y{2});
   Nxy = str2num(y{3});
   Mx = str2num(y{4});
   My = str2num(y{5});
   Mxy = str2num(y{6});
   
   NM = [Nx; Ny; Nxy; Mx; My; Mxy];
end
   