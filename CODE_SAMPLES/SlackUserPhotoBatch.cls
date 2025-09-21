/** Redacted sample */
public with sharing class SlackUserPhotoBatch implements Database.Batchable<User>, Database.Stateful {
  public SlackUserPhotoBatch() {}
  public SlackUserPhotoBatch(Integer scopeSize) {}
  public Database.QueryLocator start(Database.BatchableContext bc){ return Database.getQueryLocator('SELECT Id FROM User'); }
  public void execute(Database.BatchableContext bc, List<User> scope){/* redacted */}
  public void finish(Database.BatchableContext bc){}
}
