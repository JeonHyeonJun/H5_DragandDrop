<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html ng-app="drag-and-drop">
  <head lang="en">
    <meta charset="utf-8">
    <title>Drag & Drop: Multiple listsr</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1/jquery-ui.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.2.0/angular.min.js"></script>
    <link href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/themes/ui-lightness/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="https://netdna.bootstrapcdn.com/twitter-bootstrap/2.1.1/css/bootstrap.min.css" rel="stylesheet">
    <script src="resources/js/angular-dragdrop.min.js"></script>
    <script src="resources/js/agdrag.js"></script>
    <style>
      .thumbnail { height: 280px !important; }
      .btn-droppable { width: 180px; height: 30px; padding-left: 4px; }
      .btn-draggable { width: 160px; }
    </style>
  </head>
  <body>
    <div ng-controller="oneCtrl">
      <div class='contentWrapper ng-cloak'>
        <div class='content'>
          <div class="row-fluid">
            <ul class="thumbnails">
              <li class="span3" style='margin-left:10px;'>
                <div class="thumbnail" data-drop="true" ng-model='list1' data-jqyoui-options="optionsList1" jqyoui-droppable="{multiple:true}">
                  <div class="caption">
                    <div class="btn btn-info btn-draggable" ng-repeat="item in list1" ng-show="item.title" data-drag="{{item.drag}}" data-jqyoui-options="{revert: 'invalid'}" ng-model="list1" jqyoui-draggable="{index: {{$index}},animate:true}">{{item.title}}</div>
                  </div>
                </div>
              </li>
              <li class="span3" style='margin-left:10px;'>
                <div class="thumbnail" data-drop="true" ng-model='list2' data-jqyoui-options="{accept:'.btn-draggable:not([ng-model=list2])'}"  jqyoui-droppable="{multiple:true}">
                  <div class="caption">
                    <div class="btn btn-info btn-draggable" ng-repeat="item in list2" ng-show="item.title" data-drag="{{item.drag}}" data-jqyoui-options="{revert: 'invalid'}" ng-model="list2" jqyoui-draggable="{index: {{$index}},animate:true}">{{item.title}}</div>
                  </div>
                </div>
              </li>
              <li class="span3" style='margin-left:10px;'>
                <div class="thumbnail" data-drop="true" ng-model='list3' data-jqyoui-options="{accept:'.btn-draggable:not([ng-model=list3])'}"  jqyoui-droppable="{multiple:true}">
                  <div class="caption">
                    <div class="btn btn-info btn-draggable" ng-repeat="item in list3" ng-show="item.title" data-drag="{{item.drag}}" data-jqyoui-options="{revert: 'invalid'}" ng-model="list3" jqyoui-draggable="{index: {{$index}},animate:true}">{{item.title}}</div>
                  </div>
                </div>
              </li>
              <li class="span3" style='margin-left:10px;'>
                <div class="thumbnail" data-drop="true" ng-model='list4' data-jqyoui-options="{accept:'.btn-draggable:not([ng-model=list4])'}"  jqyoui-droppable="{multiple:true}">
                  <div class="caption">
                    <div class="btn btn-info btn-draggable" ng-repeat="item in list4" ng-show="item.title" data-drag="{{item.drag}}" data-jqyoui-options="{revert: 'invalid'}" ng-model="list4" jqyoui-draggable="{index: {{$index}},animate:true}">{{item.title}}</div>
                  </div>
                </div>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div class="navbar-inner">
        <div class="container form-inline" style="text-align: center;">
          <div class="btn btn-droppable" ng-repeat="item in list5" data-drop="true" ng-model='list5' data-jqyoui-options="{accept:'.btn-draggable:not([ng-model=list5])'}"  jqyoui-droppable="{index: {{$index}}}">
            <div class="btn btn-info btn-draggable" data-drag="{{item.drag}}" data-jqyoui-options="{revert: 'invalid'}" ng-model="list5" jqyoui-draggable="{index: {{$index}},placeholder:true,animate:true}" ng-hide="!item.title">{{item.title}}</div>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>