<#if header??>
${header}
</#if>
package ${config.providerJavaPackage}.${entity.packageName};

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
     * @param asynchronousDbHelper
     */
    public ${entity.nameCamelCase}AsyncHandler(AsynchronousDbHelper<${entity.nameCamelCase}Model, Long> asynchronousDbHelper) {
        super(asynchronousDbHelper, (TypedDatabaseSource<Long, Uri, ${entity.nameCamelCase}Cursor>) asynchronousDbHelper.getDataSource());
    }
}
