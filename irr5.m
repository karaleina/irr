clear all; close all;
[Polozenia_abs] = xlsread('irr_lab5.xlsx');

Srodek_ukladu = [132, 551];
Polozenia = Polozenia_abs;

% Petla po wszystkich kolumnach przesuwajaca dane wzgledem srodka ukladu
% wspolrzedncyh
for x=1:length(Polozenia_abs(1,:))
    if x(mod(x, 2) == 0)
        % Minus bo chcemy wrocic do intuicyjnego ukladu wspolrzednych na
        % osi y
        Polozenia(:,x) = -(Polozenia(:,x) - Srodek_ukladu(2));
    else
        Polozenia(:,x) = Polozenia(:,x) - Srodek_ukladu(1);
    end
end

% Wszystkie polozenia sa juz przesuniete wzgledem srodka wspolrzednych

% Polozenia
Kostka2 = Polozenia(:, 1:2);
Pieta = Polozenia(:, 3:4);
Palec = Polozenia(:, 5:6);
Kostka = Polozenia(:, 7:8);
Kolano = Polozenia(:, 9:10);
Biodro = Polozenia(:, 11:12);


% Kat rozwarty utworzony przez punkty 1 i 2 i polprosta rownolegla do osi x
% przechodzaca przez punkt 2
b = (Biodro(:,2) - Kolano(:,2));
a = (Biodro(:,1) - Kolano(:,1));

for i=1:length(Biodro(:,2))
    if a(i)>0 
        % jeśli kat ostry
        Kat21(i) = atan(b(i)/a(i))*(180/pi);
    else
        % jeśli kąt rozwarty
        Kat21(i) = 180 - atan(b(i)/abs(a(i)))*(180/pi);
    end
end

% Kat rozwarty utworzony przez punkty 3=2 i 4 i polprosta rownolegla do osi x
% przechodzaca przez punkt 4
b2 = (Kolano(:,2) - Kostka(:, 2));
a2 = (Kolano(:,1) - Kostka(:, 1));

for i=1:length(Kolano(:,2))
    if a2(i)>0 
        % jeśli kat ostry
        Kat43(i) = atan(b2(i)/a2(i))*(180/pi);
    else
        % jesli rozwarty
        Kat43(i) = 180 - atan(b2(i)/abs(a2(i)))*(180/pi);
    end
end

% SZUKANE: Poszukiwany w 1. przypadku kat  u odniesieniu do statyki).
Knee_kat = Kat21 - Kat43;
Knee_kat_statyka = Kat21(end) - Kat43(end);
Knee_kat_real = Knee_kat(:) - Knee_kat_statyka;


%% %%

% Dla drugiego szukanego kąta => Liczymy kąt 65


% Kat rozwarty utworzony przez punkty 6 i 5 i polprosta rownolegla do osi x
% przechodzaca przez punkt 5

b3 = (Kostka2(:,2) - Palec(:, 2));
a3 = (Kostka2(:,1) - Palec(:, 1));

for i=1:length(Kostka2(:,2))
    if a3(i)>0 
        % jeśli kat ostry
        Kat65(i) = atan(b3(i)/a3(i))*(180/pi);
    else
        % jesli rozwarty
        Kat65(i) = 180 - atan(b3(i)/abs(a3(i)))*(180/pi);
    end
end

% Drugi poszukiwany kąt (statyka)
Ankle_kat = Kat43 - Kat65 + 90;
Ankle_kat_statyka = Kat43(end) - Kat65(end) + 90;
Ankle_kat_real = Ankle_kat(:) - Ankle_kat_statyka;


%% 

% Trzeci poszukiwany kąt miedzy punktami 2 5 i 6

% Do tego potrzebujemy policzyc kąt 53

b4 = (Kolano(:,2) - Pieta(:, 2));
a4 = (Kolano(:,1) - Pieta(:, 1));

for i=1:length(Kolano(:,2))
    if a4(i)>0 
        % jeśli kat ostry
        Kat53(i) = atan(b4(i)/a4(i))*(180/pi);
    else
        % jesli rozwarty
        Kat53(i) = 180 - atan(b4(i)/abs(a4(i)))*(180/pi);
    end
end



% Trzeci poszukiwany kąt (statyka)
Ankle_kat_2 = Kat53 - Kat65 + 90;
Ankle_kat_2_statyka = Kat53(end) - Kat65(end) + 90;
Ankle_kat_2_real = Ankle_kat_2(:) - Ankle_kat_2_statyka;


% RYSOWANIE
katy = [Knee_kat_real';
            Ankle_kat_real';
            Ankle_kat_2_real'];
labels_y = {'Kąt kolanowy w stopniach';
                   'Kąt skokowy w stopniach';
                   'Kat skokowy w stopniach'};
labels_title = {'Staw kolanowy prawej nogi';
                   'Staw skokowy prawej nogi - metoda I';
                   'Staw skokowy prawej nogi - metoda II'};
        
t = 1:1:length(katy(1, :));

for i=1:3
    figure(i)
    plot(t, katy(i,:), 'b-');
    ylabel(labels_y{i})
    xlabel('t')
    title(labels_title{i});
end




