%% APLICAR_CORRECCION_MAGNETICA - Aplica corrección magnética a componentes U/V mediante rotación horizontal
%   [U_verdadero, V_verdadero] = rotate_uv(u, v, theta) ajusta los componentes de 
%   velocidad horizontal rotándolos con un ángulo de declinación magnética para 
%   convertir desde coordenadas magnéticas a coordenadas verdaderas.
%
%   La función realiza una rotación matemática estándar en el plano horizontal:
%   - Sentido antihorario (contrario a las manecillas del reloj) para ángulos positivos
%   - Utiliza trigonometría en grados (sind/cosd) para evitar conversiones manuales
%
% Parámetros de entrada:
%   u    = Componente original de velocidad Este magnética (escalar/vector/matriz)
%   v    = Componente original de velocidad Norte magnética (mismas dimensiones que u)
%   theta = Ángulo de declinación magnética [grados]. Valor positivo cuando el 
%           Norte verdadero está al ESTE del Norte magnético (convención estándar).
%
% Parámetros de salida:
%   U_verdadero = Componente de velocidad rotado en dirección Este verdadera
%   V_verdadero = Componente de velocidad rotado en dirección Norte verdadera
%
% Notas de uso:
%   - Diseñada para trabajar con datos de ADCP/currentómetros u otros sensores
%     que miden direcciones relativas al Norte magnético
%   - Compatible con arrays multidimensionales (operación vectorizada)
%   - Para revertir la corrección, usar ángulo negativo: rotate_uv(u_verdadero, v_verdadero, -theta)
%
% Ejemplo de aplicación:
%   theta = 15; % Declinación magnética = 15° Este (Norte verdadero 15° E del magnético)
%   [u_true, v_true] = rotate_uv(u_mag, v_mag, theta); % Corrección a coordenadas verdaderas
%
% Referencias geomagnéticas:
%   Los valores de theta pueden obtenerse de modelos como IGRF o WMM mediante
%   calculadoras en línea (ej: NOAA https://www.ngdc.noaa.gov/geomag/calculators/magnetic_declination.shtml)
%
% Detalles de implementación:
%   Utiliza la matriz de rotación 2D:
%   [ cosd(theta)  -sind(theta)
%     sind(theta)   cosd(theta) ]

function [u_corr, v_corr] = rotate_uv(u, v, theta)
    u_corr = u * cosd(theta) - v * sind(theta);
    v_corr = u * sind(theta) + v * cosd(theta);
end