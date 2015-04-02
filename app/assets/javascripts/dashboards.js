$(document).on('page:change', function() {

    function removeModule(moduleDiv, dashId, inDb) {
        //moduleName.ch
        if(inDb){
          
          var moduleId = moduleDiv.find('.module-id-field').val();
          $.ajax({
            url: dashId + "/modules/match_history_modules/" + moduleId, // Route to the Script Controller method
            type: "DELETE",
            error: function() {
                alert("Error");
            }
        });
        }
        moduleDiv.remove();

    }

    function saveModule(moduleDiv, dashId, isUpdate) {
        var accountId = moduleDiv.find('.acc-list').val();
        var nbMatch = moduleDiv.find('.nb-list').val();
        var type = isUpdate ? "PATCH":"POST";
        var moduleId = moduleDiv.find('.module-id-field').val();
        var urlAppend = isUpdate ? moduleId : "";
        $.ajax({
            url: dashId + "/modules/match_history_modules/"+urlAppend, // Route to the Script Controller method
            type: type,
            data: {
                module_infos: {
                    nb_match: nbMatch,
                    dash_id: dashId,
                    account_id: accountId
                }
            },
            success: function(data) {
                moduleDiv.empty();
                moduleDiv.removeClass('well');
                moduleDiv.append(data);
                addShowButtonsListeners(moduleDiv);
            },
            error: function() {
                alert("Error");
            }
        });
    }

    function editModule(moduleDiv) {
        var dashId = $('#dash-id').val();
        var moduleId = moduleDiv.find('.module-id-field').val();

        $.ajax({
            url: dashId + "/modules/match_history_modules/" + moduleId + "/edit/", // Route to the Script Controller method
            type: "GET",
            success: function(data) {
                moduleDiv.empty();
                moduleDiv.append(data);
                moduleDiv.addClass('well');
                addEditButtonsListeners(moduleDiv, true);
            },
            error: function() {
                alert("Ajax error!");
            }
        });
    }
  
  
    function addShowButtonsListeners(moduleDiv){
      
      
      moduleDiv.find('.edit-module-history').click(function() {
                    var moduleDiv = $(this).closest('.module-holder');
                    editModule(moduleDiv);
                });
    }
    function addEditButtonsListeners(moduleDiv, exists){
        var dashId = $('#dash-id').val();
        moduleDiv.on('click', '.close', function() {
            removeModule(moduleDiv, dashId, exists);
        });

        moduleDiv.on('click', '.save-btn', function() {
            saveModule(moduleDiv, dashId, exists);
        });
    }

    $('#add-module-history').click(function() {

        var holder = $('#dashboard-holder');
        var moduleDiv = $('<div />', {
            'class': 'module-holder well col-md-6'
        });
        //var formButton = "";
        var dashId = $('#dash-id').val();
        $.ajax({
            url: dashId + "/modules/match_history_modules/new", 
            type: "GET",
            success: function(data) {

                moduleDiv.append(data);
            },
            error: function() {
                alert("Ajax error!")
            }
        });

        holder.append(moduleDiv);

        addEditButtonsListeners(moduleDiv, false);


    });
  
  
  
    $('.edit-module-history').click(function() {
        var moduleDiv = $(this).closest('.module-holder');

        editModule(moduleDiv);


    });

});