package pxlwolf_odin

import "base:runtime"
import "core:fmt"
import "core:log"
import "core:os"
import "core:path/filepath"
import "core:time"
import "core:time/datetime"
import "core:math"


main :: proc()
{
    context.logger = log.create_multi_logger(log.create_console_logger())
    log.infof("Application started")

    context.logger = create_logger()
    defer log.destroy_multi_logger(context.logger)

    log.infof("Doing stuff")

    log.infof("Application stopped")
}

create_logger :: proc() -> log.Logger
{
    logger: log.Logger
    log_file_name := createLogPath()
    flags: int = os.O_CREATE | os.O_TRUNC | os.O_WRONLY
    mode: int = os.S_IRUSR | os.S_IWUSR | os.S_IRGRP | os.S_IROTH
    if log_handle, err := os.open(log_file_name, flags, mode); err == 0
    {
        logger = log.create_multi_logger(log.create_console_logger(), log.create_file_logger(log_handle),)
        context.logger = logger
        log.log(.Info, "Creating multi_logger")
    } else {
        logger = log.create_multi_logger(log.create_console_logger())
        context.logger = logger
        log.logf(.Warning, "Log file could not be created! Filename: {}", log_file_name)
    }
    return logger
}


// Lifted from https://github.com/xandaron/Valhalla/
createLogPath :: proc() -> string {
    if !os.exists("./logs") do os.make_directory("./logs")

    right_now := time.now()

    year, month, day := time.date(right_now)

    the_date: datetime.DateTime = { date = datetime.Date{year = (i64)(year), month = (i8)(month), day = (i8)(day)},}

    midnight, _ := time.datetime_to_time(the_date)
    seconds := math.floor(time.duration_seconds(time.diff(midnight, right_now)))
    hours := math.floor(seconds / time.SECONDS_PER_HOUR)
    seconds -= hours * time.SECONDS_PER_HOUR
    minutes := math.floor(seconds / time.SECONDS_PER_MINUTE)
    seconds -= minutes * time.SECONDS_PER_MINUTE

    return fmt.tprintf("./logs/{:4i}{:2i}{:2i}{:2.0f}{:2.0f}{:2.0f}.log", the_date.year, the_date.month, the_date.day,
                       hours, minutes, seconds, )
}
