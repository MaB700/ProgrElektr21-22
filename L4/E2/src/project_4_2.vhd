library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_4_2 is
    port (
        CLK : in std_logic;
        SW : in std_logic_vector(13 downto 0);
        C : out std_logic_vector(7 downto 0);
        A : out std_logic_vector(3 downto 0)
    );
end project_4_2;

architecture Behavioral of project_4_2 is
    signal wire_bin_dec : std_logic_vector(15 downto 0) := (others => '0');
    signal valid : std_logic := '0';
    signal error : std_logic_vector(15 downto 0);
    signal dist_in : std_logic_vector(15 downto 0) := (others => '0');
    signal A_out : std_logic_vector(3 downto 0);
begin
    error(15 downto 12) <= x"E"; -- not needed
    error(11 downto 8) <= x"E"; -- not needed
    error(7 downto 4) <= x"E"; -- not needed
    error(3 downto 0) <= x"E"; -- error message

    dist_in <= wire_bin_dec when valid = '1' else -- check if error massage has to be shown
               error;

    A <= A_out when valid = '1' else -- error message will only show 1 E on the far right display segment
         "1110";

    Display : entity work.project_4_1 -- display entity using the multiplexer and running at 400Hz
        port map(
            CLK => CLK,
            SW => dist_in,
            C => C,
            A => A_out
        );

    BCD : entity work.BCD -- convert binary to Binary-coded decimal, one 4-bit binary number corresponds to
        port map( -- a single decimal digit
            BIN => SW,
            BCD => wire_bin_dec,
            VALID => valid
        );

end Behavioral;