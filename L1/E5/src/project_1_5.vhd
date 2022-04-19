library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity project_1_5 is
    port (
        A : in std_logic_vector (7 downto 0); -- A[0:7] are the first 8 switches, names changed to A[i] in the .xdc file
        B : in std_logic_vector (7 downto 0); -- B[0:7] are the last 8 switches, names changed to B[i] in the .xdc file
        S : out std_logic_vector (8 downto 0) -- S[0:8] are the 9 LED's, names changed to S[i] in the .xdc file
    );
end project_1_5;

architecture Behavioral of project_1_5 is
    signal wire_a_b, wire_b_c, wire_c_d, wire_d_e, wire_e_f, wire_f_g, wire_g_h, wire_h_i : std_logic;
    --  signal wire : std_logic_vector (8 downto 0); -- 9 size to include fist input '0'
begin
    --  alternative: loop over entities with wire vector, will create 8 instances

    --  wire(0) <= '0'; -- input of base block
    --  for i in 0 to 7 loop
    --      add : entity work.full_add -- all instances will have a unique name internaly
    --          port map(
    --              A => A(i),
    --              B => B(i),
    --              C_in => wire(i),
    --              C_out => wire(i+1),
    --              S => S(i)
    --          );
    --  end loop;

    add_a : entity work.full_add
        port map(
            A => A(0),
            B => B(0),
            C_in => '0', -- base full-adder block, therefore input C_in='0'
            C_out => wire_a_b,
            S => S(0)
        );

    add_b : entity work.full_add
        port map(
            A => A(1),
            B => B(1),
            C_in => wire_a_b,
            C_out => wire_b_c,
            S => S(1)
        );

    add_c : entity work.full_add
        port map(
            A => A(2),
            B => B(2),
            C_in => wire_b_c,
            C_out => wire_c_d,
            S => S(2)
        );

    add_d : entity work.full_add
        port map(
            A => A(3),
            B => B(3),
            C_in => wire_c_d,
            C_out => wire_d_e,
            S => S(3)
        );

    add_e : entity work.full_add
        port map(
            A => A(4),
            B => B(4),
            C_in => wire_d_e,
            C_out => wire_e_f,
            S => S(4)
        );

    add_f : entity work.full_add
        port map(
            A => A(5),
            B => B(5),
            C_in => wire_e_f,
            C_out => wire_f_g,
            S => S(5)
        );

    add_g : entity work.full_add
        port map(
            A => A(6),
            B => B(6),
            C_in => wire_f_g,
            C_out => wire_g_h,
            S => S(6)
        );

    add_h : entity work.full_add
        port map(
            A => A(7),
            B => B(7),
            C_in => wire_g_h,
            C_out => wire_h_i,
            S => S(7)
        );

    S(8) <= wire_h_i; -- carry over bit from the last full adder
    --  S(8) <= wire(8);

end Behavioral;