enum QuitingPath {
  suddenlyQuit,
  slowyQuit,
}

String quitingPathToString(QuitingPath path) {
  switch (path) {
    case QuitingPath.suddenlyQuit:
      return 'suddenly_quit';
    case QuitingPath.slowyQuit:
      return 'slowy_quit';
    default:
      return 'slowly_quit';
  }
}

QuitingPath quitingPathFromString(String path) {
  switch (path) {
    case 'suddenly_quit':
      return QuitingPath.suddenlyQuit;
    case 'slowy_quit':
      return QuitingPath.slowyQuit;
    default:
      return QuitingPath.slowyQuit;
  }
}
