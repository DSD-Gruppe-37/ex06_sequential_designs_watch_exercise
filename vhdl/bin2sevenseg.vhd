LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY bin2hex IS
    PORT
    (
        bin  : IN std_logic_vector(3 DOWNTO 0); -- Binary input
        Sseg : OUT std_logic_vector(6 DOWNTO 0) -- 7 segment output
    );
END bin2hex;

ARCHITECTURE behavioral OF bin2hex IS
BEGIN
    binProcess : PROCESS (bin)
    BEGIN
        CASE(bin) IS
            WHEN "0000" => Sseg <= "1000000"; -- 0
            WHEN "0001" => Sseg <= "1111001"; -- 1
            WHEN "0010" => Sseg <= "0100100"; -- 2
            WHEN "0011" => Sseg <= "0110000"; -- 3
            WHEN "0100" => Sseg <= "0011001"; -- 4
            WHEN "0101" => Sseg <= "0010010"; -- 5
            WHEN "0110" => Sseg <= "0000010"; -- 6
            WHEN "0111" => Sseg <= "1111000"; -- 7
            WHEN "1000" => Sseg <= "0000000"; -- 8
            WHEN "1001" => Sseg <= "0011000"; -- 9
            WHEN "1010" => Sseg <= "0001000"; -- A
            WHEN "1011" => Sseg <= "0000011"; -- B
            WHEN "1100" => Sseg <= "0100111"; -- C
            WHEN "1101" => Sseg <= "0100001"; -- D
            WHEN "1110" => Sseg <= "0000110"; -- E
            WHEN "1111" => Sseg <= "0001110"; -- F
            WHEN OTHERS => Sseg <= "1001001"; -- //Error display//
        END CASE;
    END PROCESS; -- binProcess
END behavioral;