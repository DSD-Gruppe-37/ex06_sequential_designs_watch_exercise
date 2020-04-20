LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

ENTITY mux IS
    PORT
    (
        -- selector
        view                   : IN std_logic;
        -- inputs
        a1, a2, a3, a4, a5, a6 : IN std_logic_vector(6 DOWNTO 0);
        b1, b2, b3, b4, b5, b6 : IN std_logic_vector(6 DOWNTO 0);
        o1, o2, o3, o4, o5, o6 : OUT std_logic_vector(6 DOWNTO 0)
    );
END ENTITY mux;
ARCHITECTURE rtl OF mux IS

BEGIN
    proc_name : PROCESS (VIEW)
    BEGIN
        CASE VIEW IS
            WHEN '0' =>
                o1 <= a1;
                o2 <= a2;
                o3 <= a3;
                o4 <= a4;
                o5 <= a5;
                o6 <= a6;
            WHEN OTHERS =>
                o1 <= b1;
                o2 <= b2;
                o3 <= b3;
                o4 <= b4;
                o5 <= b5;
                o6 <= b6;
        END CASE;
    END PROCESS proc_name;
END ARCHITECTURE rtl;