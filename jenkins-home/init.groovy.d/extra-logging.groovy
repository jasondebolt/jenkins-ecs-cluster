import java.util.logging.ConsoleHandler
import java.util.logging.FileHandler
import java.util.logging.SimpleFormatter
import java.util.logging.LogManager
import jenkins.model.Jenkins

def logsDir = new File(Jenkins.instance.rootDir, "logs")

if(!logsDir.exists()){
    println "--> creating log dir";
    logsDir.mkdirs();
}

def loggerWinstone = LogManager.getLogManager().getLogger("");
FileHandler handlerWinstone = new FileHandler(logsDir.absolutePath + "/jenkins-winstone.log", 1024 * 1024, 10, true);

handlerWinstone.setFormatter(new SimpleFormatter());
loggerWinstone.addHandler (new ConsoleHandler());
loggerWinstone.addHandler(handlerWinstone);
