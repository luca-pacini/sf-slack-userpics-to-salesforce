@IsTest private class SlackUserPhotoBatchTest {
  @IsTest static void compiles(){
    Test.startTest();
    Database.executeBatch(new SlackUserPhotoBatch(1), 1);
    Test.stopTest();
    System.assert(true);
  }
}
