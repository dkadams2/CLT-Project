function [filename] = askfilename()

%Create a dialog box that prompts the user to put in number of plies in
%composite, then pass that number back
prompt = {'Please input the name of the file you would like to create for the composite data: '};
dlg_title = 'Filename';
def = {'CLT output'};
   num_lines = 1;
   answer = inputdlg(prompt,dlg_title,num_lines,def);
  filename = answer;
end
   
