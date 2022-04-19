library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity project_4_1_1 is
    port (
        CLK : in std_logic;
        C0 : in std_logic_vector(7 downto 0);
        C1 : in std_logic_vector(7 downto 0);
        C2 : in std_logic_vector(7 downto 0);
        C3 : in std_logic_vector(7 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_1_1;

architecture Behavioral of project_4_1_1 is
    signal count : unsigned(1 downto 0) := (others => '0');
    signal T : std_logic := '0';
begin
    clock_changer : entity work.project_3_1
        generic map(
            FREQ_IN => 100e6,
            FREQ_OUT => 400 -- 400Hz works good, so updating each display segment with 100Hz
        )
        port map(
            CLK => CLK,
            T => T
        );

    process (CLK) is
    begin
        if rising_edge(CLK) then
            if T = '1' then
                count <= count + 1; -- cycle through all 4 display segments with changing A
                if count = 0 then -- and also providing the disired output for each segment
                    C <= C0;
                    A <= "1110";
                elsif count = 1 then
                    C <= C1;
                    A <= "1101";
                elsif count = 2 then
                    C <= C2;
                    A <= "1011";
                else
                    C <= C3;
                    A <= "0111";
                    count <= (others => '0');
                end if;
            end if;
        end if;
    end process;

end Behavioral;