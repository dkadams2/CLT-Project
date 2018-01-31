function [numplies] = askplies()
%Create a dialog box that prompts the user to put in number of plies in
%composite, then pass that number back
prompt = {'Please input the number of plies in your composite: '};
dlg_title = 'Number of Plies';
def = {'6'};
   num_lines = 1;
   answer = inputdlg(prompt,dlg_title,num_lines,def);
   x = answer;
   numplies = str2num(x{1});
end
   
