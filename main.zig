const c = @cImport({
    @cInclude("stdio.h");
    @cInclude("stdlib.h");
    @cInclude("string.h");
    @cInclude("unistd.h");
    @cInclude("sys/wait.h");
});

pub fn main() void {
    var line: [1024]u8 = undefined;

    while (true) {
        _ = c.printf("zig-shell> ");
        _ = c.fflush(c.stdout);

        if (c.fgets(line[0..].ptr, @intCast(line.len), c.stdin) == null) {
            break;
        }

        var args: [64][*c]const u8 = undefined;
        var count: usize = 0;

        var token = c.strtok(line[0..].ptr, " \t\r\n");

        while (token != null and count < args.len - 1) {
            args[count] = token;
            count += 1;

            token = c.strtok(null, " \t\r\n");
        }

        if (count == 0) {
            continue;
        }

        args[count] = null;

        if (c.strcmp(args[0], "exit") == 0) {
            _ = c.printf("Encerrando o shell...\n");
            break;
        }

        const pid = c.fork();

        if (pid < 0) {
            _ = c.perror("Erro ao criar processo");
            continue;
        }

        if (pid == 0) {
            _ = c.execvp(args[0], @ptrCast(&args));

            _ = c.perror("Erro ao executar comando");
            c._exit(127);
        }

        var status: c_int = 0;
        _ = c.waitpid(pid, &status, 0);
    }
}
