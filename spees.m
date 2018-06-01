%phan tich am
[yminh,fsminh]=audioread('REC001.mp3');
yminh=yminh(:,1);
T = 1/fsminh;
time = T:T:T*length(yminh);
figure
plot(time,yminh)

%phat am
test_yminh=audioplayer(yminh,fsminh);
play(test_yminh);

%xu ly am
%excitation
[aud1_orig,fs] = audioread('REC001.mp3'); 
aud1 = aud1_orig(:,1); 
step = 1000;% 1000
order = 10 ;%10
for i = 1 : step : length(aud1)-step 
    [aud1LPC((i-1)/step+1,1:order+1),g] = lpc(aud1(i:i+step-1,1),order); 
    est_aud1((i-1)/step+1,1:step) = filter([0 -aud1LPC(1:end)],1,aud1(i:i+step-1,1)); 
    est_aud1_complete(i:i+step-1,1) = est_aud1((i-1)/step+1,1:step); 
end 
est_aud1_norm = est_aud1_complete / max(est_aud1_complete);  %source 1
test_aud1 = audioplayer(aud1,fs); 
test_est_aud1 = audioplayer(est_aud1_norm,fs); 


[aud2_orig,fs] = audioread('REC003.mp3'); 
aud2 = aud2_orig(:,1); 
for i = 1 : step : length(aud2)-step 
    [aud2LPC((i-1)/step+1,1:order+1),g] = lpc(aud2(i:i+step-1,1),order); 
    est_aud2((i-1)/step+1,1:step) = filter([0 -aud2LPC(1:end)],1,aud2(i:i+step-1,1)); 
    est_aud2_complete(i:i+step-1,1) = est_aud2((i-1)/step+1,1:step); 
end 
est_aud2_norm = est_aud2_complete / max(est_aud2_complete); %source 2
testb = audioplayer(aud2,fs); 
testa = audioplayer(est_aud2_norm,fs); 

%voice filter
preEmph = [1 -0.95];
[aaaBoy,fs] = audioread('REC001.mp3'); 
aaaBoy = aaaBoy(:,1); 
aaaBoy = filter(preEmph,1,aaaBoy); 

%xuat am thanh
h=conv(aaaBoy,est_aud2_norm);
h=filter(aaaBoy,1,est_aud2_norm);








