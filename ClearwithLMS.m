% Διάβασε wav
currentDir=pwd();
subfolder='input';
filename='bigecho.wav';
filePath = fullfile(currentDir, subfolder, filename);
[d, Fs] = audioread(filePath);
n = length(d);
disp("read file");

% Παράμετροι Φίλτρου 
mu = 0.01; % Step size
m = 100; % Πλήθος βαρών 
w = zeros(m, 1); % Πίνακας Βαρών 

% Δεύετερο σήμα εισόδου 
y = zeros(n, 1);
e = zeros(n, 1);
filename='echo.wav';
filePath = fullfile(currentDir, subfolder, filename);
u=audioread(filePath);


% LMS λούπα 
for i = m:n
    u_last = u(i:-1:i-m+1);
    
    y(i) = w' * u_last;
    e(i) = d(i) - y(i);
    
    % Υπολογισμός Βαρών 
    w = w + mu * e(i) * u_last;
    
end

% Αποθηκευσε ήχο 
subfolder="output";
filename="output100.wav";
filePath = fullfile(currentDir, subfolder, filename);
audiowrite(filePath, e, Fs);
disp("saved file");
