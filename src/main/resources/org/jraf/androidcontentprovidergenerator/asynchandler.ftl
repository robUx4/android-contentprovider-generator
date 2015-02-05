<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

import android.content.ContentValues;
import android.net.Uri;

import org.gawst.asyncdb.AsynchronousDbHelper;
import org.gawst.asyncdb.source.typed.TypedDatabaseSource;
import org.gawst.asyncdb.typed.TypedAsyncDatabaseHandler;

/**
 * Helper class to post read/write tasks for the {@code ${entity.nameLowerCase}} table.
 */
public class ${entity.nameCamelCase}AsyncHandler extends TypedAsyncDatabaseHandler<${entity.nameCamelCase}Model, ${entity.nameCamelCase}Cursor, Long, Uri> {
    /**
     * Constructor.
     *
     * @param asynchronousDbHelper asynchronous database.
     */
    public ${entity.nameCamelCase}AsyncHandler(AsynchronousDbHelper<${entity.nameCamelCase}Model, Long> asynchronousDbHelper) {
        super(asynchronousDbHelper, (TypedDatabaseSource<Long, Uri, ${entity.nameCamelCase}Cursor>) asynchronousDbHelper.getDataSource());
    }

    public void startUpdate(int token, Object cookie, ${entity.nameCamelCase}Model itemUpdate) {
        ${entity.nameCamelCase}Selection selection = new ${entity.nameCamelCase}Selection(itemUpdate);
        startUpdate(token, cookie, itemUpdate, selection.sel(), selection.args());
    }

    public void startUpdate(int token, Object cookie, ${entity.nameCamelCase}Model itemUpdate, ${entity.nameCamelCase}ContentValues values) {
        final ${entity.nameCamelCase}Selection selection = new ${entity.nameCamelCase}Selection(itemUpdate);
        final ContentValues updateValues = values.values();
        startRunnable(token, cookie, new Runnable() {
            @Override
            public void run() {
                dataSource.update(updateValues, selection.sel(), selection.args());
            }
        });
    }
}
