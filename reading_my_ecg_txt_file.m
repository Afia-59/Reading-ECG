% Execute this code part by part
% Edit your ECG file. Remove the strings that are visible. Remove the first
% pair of 6002 and 5002 as well. Then execute the code below to get rid of
%MSGTYPE string from the .txt file
%Onekgula text er por jei 6002 ta start hoise,oita rekhe diba
%Got the data from HS12 ECG
%%
clc;clear all;close all;
fid = fopen('Edited_ECG.txt','rt') ;
X = fread(fid) ;
fclose(fid) ;
X = char(X.') ;
% replace string S1 with string S2
Y = strrep(X, 'MSGTYPE', '') ;
fid2 = fopen('outfile.txt','wt') ;
fwrite(fid2,Y) ;
fclose (fid2) ;

%% Read the newly created file

clc;clear all;close all;
fid =fopen('outfile.txt');
C=textscan(fid,'%f','delimiter','\n');
data_full=cell2mat(C);

idx_start= find(data_full ==6002);
idx_end = find(data_full==5002);
idx_start = idx_start(1:end-1);

new1 = zeros(length(data_full),length(idx_end));

   for i = 1:length(idx_end)
        a=idx_start(i)+1;
        b=idx_end(i)-1;
        c=b-a+1;
        new1((1:c),i) = data_full(a:b);
   end
new1(new1==0)=[];
new1=new1';
% 
% idx_start2= find(data_full ==5000);
% idx_end2 = find(data_full==6000);
% 
% new2 = zeros(200000,length(idx_end2));
% 
% 
% for j = 1:length(idx_end2)
%         a=idx_start2(j)+1;
%         b=idx_end2(j)-1;
%         c=b-a+1;
%         new2((1:c),j) = data_full(a:b);
% end
%     
% new2(new2==0)=[];
% new2=new2';

new1(new1==6000)=[];
new1(new1==5000)=[];
sub_data=new1;

data_ch1 =sub_data(find(sub_data >=0 & sub_data <= 4095 ));
data_ch1 = log10(data_ch1);

data_ch2 =sub_data(find(sub_data >= 8192 & sub_data <= 12287 ));
data_ch2 = log10(data_ch2);
% data_ch2 = data_ch2(1:end-1);

data_ch3 =sub_data(find(sub_data >= 17408 & sub_data <= 21503 ));
data_ch3 = log10(data_ch3);
%data_ch3f = flip(data_ch3);

data_ch4 =sub_data(find(sub_data >= 25600 & sub_data <= 29695 ));
data_ch4 = log10(data_ch4);
%data_ch4f = flip(data_ch4);
% data_ch4 = data_ch4(1:end-1);

figure;
subplot(4,1,1)

x = (0:length(data_ch2)-1)/0.4;

plot(x,data_ch2,'-r.')
title('Channel 1')

subplot(4,1,2)
 %x= 1:2.5:length(data_ch2)*2.5;
plot(x,data_ch2,'-k.')
title('Channel 2')

subplot(4,1,3)
% x= 1:2.5:length(data_ch3)*2.5;
plot(x,data_ch3,'-b.')
title('Channel 3')

subplot(4,1,4)
%x= 1:2.5:length(data_ch4)*2.5;
plot(x,data_ch4,'-m.')
title('Channel 4')

total_ms = (length(data_ch2)*2.5)+48630547+500; % 500 ms between the onset of each log file, 41128445 is the LogStartMDHTime
disp(num2str(total_ms,'%.2f'))

%%%%%%%%%%%%%%%%%%%%%%%%%%


    