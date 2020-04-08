LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY Count_onedigit IS
    PORT
    (
        clk   : IN std_logic;
        reset : IN std_logic;
        mode  : IN std_logic_vector(1 DOWNTO 0);

        count : OUT std_logic_vector(3 DOWNTO 0);
        cout  : OUT std_logic
    );
END ENTITY Count_onedigit;
ARCHITECTURE structural OF Count_onedigit IS

    SIGNAL intCount :
    unsigned(3 DOWNTO 0); --- 

    SIGNAL maxCount :
    unsigned(3 DOWNTO 0);
BEGIN
    PROCESS (clk, reset, mode, intCount)

    BEGIN
        IF (rising_edge(clk)) THEN
            intCount <= intCount + 1;

            IF (intCount = maxCount) THEN

                IF (mode = "00") THEN
                    maxCount <= "1001";
                ELSIF (mode = "01") THEN
                    maxCount <= "0101";
                ELSE
                    maxCount <= "0010";
                END IF;

                intCount <= (OTHERS => '0');

            END IF;
        END IF;

        IF (reset = '1') THEN
            intCount <= (OTHERS => '0');
        END IF;

    END PROCESS;
    count <= std_logic_vector(intCount);

    PROCESS (intCount)
    BEGIN
        CASE(intCount) IS
            WHEN "0000" => cout <= '1';
            WHEN OTHERS => cout <= '1';
        END CASE;
    END PROCESS;

END ARCHITECTURE structural;